package com.rd
{
   import autoevony.common.CityStateCommands;
   import autoevony.common.CityStateConstants;
   import autoevony.event.CityStateResponseEvent;
   import autoevony.gui.MainScreen;
   import autoevony.management.CityManager;
   import autoevony.net.Connection;
   import autoevony.scripts.CityState;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.TroopBean;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class REAddons
   {
      private static var _suppressionPreTime:int = 3000;
      
      private static var _suppressionPostTime:int = 3000;
      
      private static var colonizationPostTimeOffset:Number = 1000000;
      
      private static var _colonizationPostTime:int = 3000;
      
      private static var _colonizationPostTime2:int = 3000;
      
      private static var HeroRenameTimer:Timer = null;
      
      private static var ArrayOfHerosToRename:Array = null;
      
      private static var KingRenameTimer:Timer = null;
      
      private static var KingRenameTimerCM:CityManager = null;
      
      private static var me:REAddons = null;
      
      private static var CitySuppresionTimers:Array = new Array();
      
      private static var CityColonizationTimers:Array = new Array();
      
      _suppressionPreTime = 3000;
      _suppressionPostTime = 3000;
      _colonizationPostTime = 3000;
      _colonizationPostTime2 = 3000;
      colonizationPostTimeOffset = 1000000;
      
      private static var _varAutoNames:Array = new Array();
      
      private static var suppTroopsArray:Object = new Object();
      
      private static var _varLordIgnoreRed:Array = new Array();
      
      HeroRenameTimer = null;
      ArrayOfHerosToRename = null;
      me = null;
      KingRenameTimer = null;
      KingRenameTimerCM = null;
      
      public function REAddons()
      {
         var _loc1_:TroopBean = new TroopBean();
         _loc1_.peasants = 0;
         _loc1_.militia = 0;
         _loc1_.scouter = 0;
         _loc1_.pikemen = 0;
         _loc1_.swordsmen = 0;
         _loc1_.archer = 0;
         _loc1_.lightCavalry = 0;
         _loc1_.heavyCavalry = 0;
         _loc1_.carriage = 0;
         _loc1_.ballista = 0;
         _loc1_.batteringRam = 0;
         _loc1_.catapult = 0;
         suppTroopsArray[0] = _loc1_;
         super();
      }
      
      public static function set varLordIgnoreRed(param1:Array) : void
      {
         _varLordIgnoreRed = param1;
      }
      
      public static function getInstance() : REAddons
      {
         if(me == null)
         {
            me = new REAddons();
         }
         return me;
      }
      
      public static function set varAutoNames(param1:Array) : void
      {
         _varAutoNames = param1;
      }
      
      public static function get varLordIgnoreRed() : Array
      {
         return _varLordIgnoreRed;
      }
      
      public static function get varAutoNames() : Array
      {
         return _varAutoNames;
      }
      
      public function doHeroName(param1:CityState) : void
      {
         var _loc3_:HeroBean = null;
         if(HeroRenameTimer != null)
         {
            HeroRenameTimer.removeEventListener(TimerEvent.TIMER,this.doProcessHeroNames);
         }
         else
         {
            HeroRenameTimer = new Timer(5000);
         }
         HeroRenameTimer.stop();
         ArrayOfHerosToRename = new Array();
         var _loc2_:Object = null;
         for each(_loc3_ in param1.cityManager.heroes)
         {
            _loc2_ = new Object();
            _loc2_.city = param1;
            _loc2_.hero = _loc3_;
            ArrayOfHerosToRename.push(_loc2_);
         }
         HeroRenameTimer.addEventListener(TimerEvent.TIMER,this.doProcessHeroNames);
         HeroRenameTimer.start();
      }
      
      private function doRenameKingEvent(param1:TimerEvent) : void
      {
         var _loc2_:HeroBean = null;
         KingRenameTimer.reset();
         KingRenameTimer.delay = 750;
         KingRenameTimer.repeatCount = 1;
         for each(_loc2_ in KingRenameTimerCM.heroes)
         {
            if(_loc2_.name.toLocaleLowerCase() == "king" && _loc2_.isHero == 0)
            {
               if(_loc2_.status == CityStateConstants.HERO_STATUS_IDLE || _loc2_.status == CityStateConstants.HERO_STATUS_MAYOR)
               {
                  KingRenameTimerCM.logMsg("AUTO CHANGE NAME OF NON ROYAL KING > Trying to Rename non Royal King to Kinglet","#00006A");
                  CityStateCommands.changeName(KingRenameTimerCM._getCastleId(),_loc2_.id,"Kinglet");
                  KingRenameTimerCM.setHeroUpdateNeeded(true);
                  break;
               }
               KingRenameTimerCM.logMsg("AUTO CHANGE NAME OF NON ROYAL KING > King is busy, will try again later","#00006A");
               KingRenameTimer.start();
               return;
            }
         }
         KingRenameTimerCM.logMsg("AUTO CHANGE NAME OF NON ROYAL KING > Canceling attempts to rename non royal King to \'Kinga\'","#00006A");
         KingRenameTimer.reset();
         KingRenameTimer.stop();
         KingRenameTimer = null;
         KingRenameTimer.removeEventListener(TimerEvent.TIMER,this.doRenameKingEvent);
      }
      
      private function doProcessHeroNames(param1:TimerEvent) : void
      {
         var _loc3_:String = null;
         if(!Connection.getInstance().authenticated)
         {
            ArrayOfHerosToRename = new Array();
            HeroRenameTimer.stop();
            return;
         }
         if(ArrayOfHerosToRename.length <= 0)
         {
            HeroRenameTimer.stop();
            return;
         }
         var _loc2_:Object = ArrayOfHerosToRename.shift();
         if(_loc2_.hero.status != CityStateConstants.HERO_STATUS_IDLE && _loc2_.hero.status != CityStateConstants.HERO_STATUS_MAYOR || HeroBean(_loc2_.hero).isHero > 0)
         {
            ArrayOfHerosToRename.push(_loc2_);
            HeroRenameTimer.delay = 500;
         }
         else
         {
            _loc3_ = null;
            if(_loc2_.hero.power > _loc2_.hero.stratagem && _loc2_.hero.power > _loc2_.hero.management)
            {
               _loc3_ = "a" + (_loc2_.hero.power - _loc2_.hero.level) + "i" + _loc2_.hero.stratagem + "p" + _loc2_.hero.management;
            }
            else if(_loc2_.hero.stratagem > _loc2_.hero.power && _loc2_.hero.stratagem > _loc2_.hero.management)
            {
               _loc3_ = "i" + (_loc2_.hero.stratagem - _loc2_.hero.level) + "a" + _loc2_.hero.power + "p" + _loc2_.hero.management;
            }
            else if(_loc2_.hero.management > _loc2_.hero.power && _loc2_.hero.management > _loc2_.hero.stratagem)
            {
               _loc3_ = "p" + (_loc2_.hero.management - _loc2_.hero.level) + "a" + _loc2_.hero.power + "i" + _loc2_.hero.stratagem;
            }
            if(_loc2_.hero.name.toLowerCase() != _loc3_.toLowerCase())
            {
               _loc2_.city.dispatchEvent(new CityStateResponseEvent("Hero Rename: " + _loc2_.hero.name + " to: " + _loc3_,"","#ff0000"));
               _loc2_.city.changeheroname(_loc2_.hero.name,_loc3_);
               HeroRenameTimer.delay = 5000 + Math.floor(Math.random() * 5000);
            }
            else
            {
               _loc2_.city.dispatchEvent(new CityStateResponseEvent("Not Renaming Hero: " + _loc2_.hero.name,"","#ff0000"));
               HeroRenameTimer.delay = 500;
            }
         }
         HeroRenameTimer.start();
      }
      
      public function renameKing(param1:CityManager) : void
      {
         if(KingRenameTimer != null)
         {
            KingRenameTimerCM = param1;
            KingRenameTimer = new Timer(750);
            KingRenameTimer.delay = 750;
            KingRenameTimer.repeatCount = 1;
            KingRenameTimer.addEventListener(TimerEvent.TIMER,this.doRenameKingEvent);
            KingRenameTimer.start();
         }
      }
      
      public function doHeroNames() : void
      {
         var _loc2_:CityState = null;
         var _loc3_:HeroBean = null;
         if(HeroRenameTimer != null)
         {
            HeroRenameTimer.removeEventListener(TimerEvent.TIMER,this.doProcessHeroNames);
         }
         else
         {
            HeroRenameTimer = new Timer(5000);
         }
         HeroRenameTimer.stop();
         ArrayOfHerosToRename = new Array();
         var _loc1_:Object = null;
         for each(_loc2_ in MainScreen.getCities())
         {
            for each(_loc3_ in _loc2_.cityManager.heroes)
            {
               _loc1_ = new Object();
               _loc1_.city = _loc2_;
               _loc1_.hero = _loc3_;
               ArrayOfHerosToRename.push(_loc1_);
            }
         }
         HeroRenameTimer.addEventListener(TimerEvent.TIMER,this.doProcessHeroNames);
         HeroRenameTimer.start();
      }
   }
}

