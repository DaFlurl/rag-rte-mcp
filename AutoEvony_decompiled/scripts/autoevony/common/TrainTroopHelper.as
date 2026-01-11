package autoevony.common
{
   import autoevony.scripts.CityState;
   import com.evony.common.beans.BuildingBean;
   import com.evony.common.beans.CastleResourceBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.constants.BuildingConstants;
   import com.evony.common.constants.TFConstants;
   import com.evony.common.constants.TechConstants;
   
   public class TrainTroopHelper
   {
      
      private static var m_troopinfo:Object = null;
      
      public function TrainTroopHelper()
      {
         super();
      }
      
      private static function getMaxAmountResourceOnly(param1:CityState, param2:int) : Number
      {
         staticInit();
         var _loc3_:Number = -1;
         var _loc4_:TroopInfo = m_troopinfo[String(param2)];
         var _loc5_:CastleResourceBean = param1.castle.resource;
         if(_loc4_.food > 0)
         {
            _loc3_ = myMin(_loc3_,_loc5_.food.amount / Number(_loc4_.food),-1);
         }
         if(_loc4_.wood > 0)
         {
            _loc3_ = myMin(_loc3_,_loc5_.wood.amount / Number(_loc4_.wood),-1);
         }
         if(_loc4_.stone > 0)
         {
            _loc3_ = myMin(_loc3_,_loc5_.stone.amount / Number(_loc4_.stone),-1);
         }
         if(_loc4_.iron > 0)
         {
            _loc3_ = myMin(_loc3_,_loc5_.iron.amount / Number(_loc4_.iron),-1);
         }
         if(_loc3_ == -1)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public static function lookupName(param1:int) : String
      {
         staticInit();
         var _loc2_:String = "Error";
         if(m_troopinfo.hasOwnProperty(String(param1)))
         {
            _loc2_ = m_troopinfo[String(param1)].name;
         }
         return _loc2_;
      }
      
      private static function myMin(param1:Number, param2:Number, param3:Number = NaN) : Number
      {
         var _loc4_:Number = NaN;
         if(!isNaN(param3) && param1 == param3)
         {
            _loc4_ = param2;
         }
         else if(param1 < param2)
         {
            _loc4_ = param1;
         }
         else if(param2 <= param1)
         {
            _loc4_ = param2;
         }
         return _loc4_;
      }
      
      public static function getTrainObj(param1:CityState, param2:TroopBean, param3:int, param4:Boolean, param5:int) : Object
      {
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:MaxAmount = null;
         staticInit();
         var _loc6_:Object = {
            "troopid":0,
            "barrackid":0,
            "amount":0,
            "errormsg":""
         };
         if(param2 == null)
         {
            _loc6_.errormsg = "Invalid troops";
         }
         else
         {
            _loc7_ = 0;
            for(_loc8_ in m_troopinfo)
            {
               if(param2[m_troopinfo[_loc8_].troopbeanname] > 0)
               {
                  _loc6_.troopid = int(_loc8_);
                  _loc6_.amount = param2[m_troopinfo[_loc8_].troopbeanname];
                  _loc7_++;
               }
            }
            if(_loc7_ != 1)
            {
               _loc6_.troopid = 0;
               _loc6_.amount = 0;
               if(_loc7_ > 1)
               {
                  _loc6_.errormsg = "Only one troop type allowed";
               }
               else
               {
                  _loc6_.errormsg = "No troop type found";
               }
            }
            else if(_loc6_.amount <= 0)
            {
               _loc6_.errormsg = "Must specify 1 or more amount to train";
            }
            else
            {
               _loc9_ = getMaxAmount(param1,_loc6_.troopid,param3,param4);
               if(_loc9_.max <= 0 || _loc9_.max < param5)
               {
                  _loc6_.errormsg = "Cannot train " + lookupName(_loc6_.troopid) + " lacking:";
                  if(!_loc9_.hasresearch)
                  {
                     _loc6_.errormsg += " research";
                  }
                  if(!_loc9_.hasbarrack)
                  {
                     _loc6_.errormsg += " barrack";
                  }
                  if(_loc9_.maxbyresource < param5)
                  {
                     _loc6_.errormsg += " resources (max troops by resources:" + _loc9_.maxbyresource + ") ";
                  }
                  if(_loc9_.maxbypop < param5)
                  {
                     _loc6_.errormsg += " idle pop (max troops by pop:" + _loc9_.maxbypop + ") ";
                  }
               }
               else
               {
                  _loc6_.amount = Math.min(_loc9_.max,_loc6_.amount);
                  _loc6_.barrackid = _loc9_.barrackid;
               }
            }
         }
         return _loc6_;
      }
      
      private static function getMaxAmount(param1:CityState, param2:int, param3:int, param4:Boolean) : MaxAmount
      {
         staticInit();
         var _loc5_:MaxAmount = new MaxAmount();
         var _loc6_:int = getValidBarrackId(param1,param2,param3,param4);
         _loc5_.hasbarrack = _loc6_ > -1;
         _loc5_.barrackid = _loc5_.hasbarrack ? int(_loc6_) : 0;
         _loc5_.hasresearch = cityHasEnoughResearch(param1,param2);
         _loc5_.maxbypop = getMaxAmountPopulationOnly(param1,param2);
         _loc5_.maxbyresource = getMaxAmountResourceOnly(param1,param2);
         if(_loc5_.hasresearch && _loc5_.hasbarrack)
         {
            _loc5_.maxNumber = myMin(_loc5_.maxbypop,_loc5_.maxbyresource);
            if(_loc5_.maxNumber >= int.MAX_VALUE)
            {
               _loc5_.max = int.MAX_VALUE;
            }
            else
            {
               _loc5_.max = int(_loc5_.maxNumber);
            }
         }
         return _loc5_;
      }
      
      private static function troopinfoInit() : void
      {
         m_troopinfo = new Object();
         m_troopinfo[String(TFConstants.T_PEASANTS)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_PEASANTS)].name = "worker";
         m_troopinfo[String(TFConstants.T_PEASANTS)].shortname = "wo";
         m_troopinfo[String(TFConstants.T_PEASANTS)].troopbeanname = "peasants";
         m_troopinfo[String(TFConstants.T_PEASANTS)].pop = 1;
         m_troopinfo[String(TFConstants.T_PEASANTS)].food = 50;
         m_troopinfo[String(TFConstants.T_PEASANTS)].wood = 150;
         m_troopinfo[String(TFConstants.T_PEASANTS)].stone = 0;
         m_troopinfo[String(TFConstants.T_PEASANTS)].iron = 10;
         m_troopinfo[String(TFConstants.T_PEASANTS)].level = 1;
         m_troopinfo[String(TFConstants.T_PEASANTS)].minutes = 50 / 60;
         m_troopinfo[String(TFConstants.T_PEASANTS)].tech = new Array();
         m_troopinfo[String(TFConstants.T_MILITIA)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_MILITIA)].name = "warrior";
         m_troopinfo[String(TFConstants.T_MILITIA)].shortname = "warr";
         m_troopinfo[String(TFConstants.T_MILITIA)].troopbeanname = "militia";
         m_troopinfo[String(TFConstants.T_MILITIA)].pop = 1;
         m_troopinfo[String(TFConstants.T_MILITIA)].food = 80;
         m_troopinfo[String(TFConstants.T_MILITIA)].wood = 100;
         m_troopinfo[String(TFConstants.T_MILITIA)].stone = 0;
         m_troopinfo[String(TFConstants.T_MILITIA)].iron = 150;
         m_troopinfo[String(TFConstants.T_MILITIA)].level = 1;
         m_troopinfo[String(TFConstants.T_MILITIA)].minutes = 25 / 60;
         m_troopinfo[String(TFConstants.T_MILITIA)].tech = new Array();
         m_troopinfo[String(TFConstants.T_SCOUTER)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_SCOUTER)].name = "scout";
         m_troopinfo[String(TFConstants.T_SCOUTER)].shortname = "scout";
         m_troopinfo[String(TFConstants.T_SCOUTER)].troopbeanname = "scouter";
         m_troopinfo[String(TFConstants.T_SCOUTER)].pop = 1;
         m_troopinfo[String(TFConstants.T_SCOUTER)].food = 120;
         m_troopinfo[String(TFConstants.T_SCOUTER)].wood = 200;
         m_troopinfo[String(TFConstants.T_SCOUTER)].stone = 0;
         m_troopinfo[String(TFConstants.T_SCOUTER)].iron = 150;
         m_troopinfo[String(TFConstants.T_SCOUTER)].level = 2;
         m_troopinfo[String(TFConstants.T_SCOUTER)].minutes = 1 + 40 / 60;
         m_troopinfo[String(TFConstants.T_SCOUTER)].tech = new Array();
         m_troopinfo[String(TFConstants.T_SCOUTER)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_SCOUTER)].tech[0].id = TechConstants.SCOUT_SKILL;
         m_troopinfo[String(TFConstants.T_SCOUTER)].tech[0].level = 1;
         m_troopinfo[String(TFConstants.T_PIKEMAN)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_PIKEMAN)].name = "pike";
         m_troopinfo[String(TFConstants.T_PIKEMAN)].shortname = "pike";
         m_troopinfo[String(TFConstants.T_PIKEMAN)].troopbeanname = "pikemen";
         m_troopinfo[String(TFConstants.T_PIKEMAN)].pop = 1;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].food = 150;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].wood = 500;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].stone = 0;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].iron = 100;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].level = 2;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].minutes = 2.5;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].tech = new Array();
         m_troopinfo[String(TFConstants.T_PIKEMAN)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_PIKEMAN)].tech[0].id = TechConstants.COMBAT_SKILL;
         m_troopinfo[String(TFConstants.T_PIKEMAN)].tech[0].level = 1;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].name = "sword";
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].shortname = "sword";
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].troopbeanname = "swordsmen";
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].pop = 1;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].food = 200;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].wood = 150;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].stone = 0;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].iron = 400;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].level = 3;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].minutes = 3 + 45 / 60;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech = new Array();
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech[0].id = TechConstants.DEFEND_SKILL;
         m_troopinfo[String(TFConstants.T_SWORDSMEN)].tech[0].level = 1;
         m_troopinfo[String(TFConstants.T_ARCHER)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_ARCHER)].name = "archer";
         m_troopinfo[String(TFConstants.T_ARCHER)].shortname = "arch";
         m_troopinfo[String(TFConstants.T_ARCHER)].troopbeanname = "archer";
         m_troopinfo[String(TFConstants.T_ARCHER)].pop = 2;
         m_troopinfo[String(TFConstants.T_ARCHER)].food = 300;
         m_troopinfo[String(TFConstants.T_ARCHER)].wood = 350;
         m_troopinfo[String(TFConstants.T_ARCHER)].stone = 0;
         m_troopinfo[String(TFConstants.T_ARCHER)].iron = 300;
         m_troopinfo[String(TFConstants.T_ARCHER)].level = 4;
         m_troopinfo[String(TFConstants.T_ARCHER)].minutes = 5 + 50 / 60;
         m_troopinfo[String(TFConstants.T_ARCHER)].tech = new Array();
         m_troopinfo[String(TFConstants.T_ARCHER)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_ARCHER)].tech[0].id = TechConstants.THROW_SKILL;
         m_troopinfo[String(TFConstants.T_ARCHER)].tech[0].level = 1;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].name = "cavalry";
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].shortname = "cav";
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].troopbeanname = "lightCavalry";
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].pop = 3;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].food = 1000;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].wood = 600;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].stone = 0;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].iron = 500;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].level = 5;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].minutes = 8 + 20 / 60;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech = new Array();
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech[0].id = TechConstants.DRIVE_SKILL;
         m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].tech[0].level = 1;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].name = "cataphract";
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].shortname = "phrac";
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].troopbeanname = "heavyCavalry";
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].pop = 6;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].food = 2000;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].wood = 500;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].stone = 0;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].iron = 2500;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].level = 7;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].minutes = 25;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech = new Array();
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[0].id = TechConstants.DRIVE_SKILL;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[0].level = 5;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[1] = new IdLevel();
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[1].id = TechConstants.DEFEND_SKILL;
         m_troopinfo[String(TFConstants.T_HEAVYCAVALRY)].tech[1].level = 5;
         m_troopinfo[String(TFConstants.T_CARRIAGE)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_CARRIAGE)].name = "transporter";
         m_troopinfo[String(TFConstants.T_CARRIAGE)].shortname = "tran";
         m_troopinfo[String(TFConstants.T_CARRIAGE)].troopbeanname = "carriage";
         m_troopinfo[String(TFConstants.T_CARRIAGE)].pop = 4;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].food = 600;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].wood = 1500;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].stone = 0;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].iron = 350;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].level = 6;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].minutes = 16 + 40 / 60;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].tech = new Array();
         m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0].id = TechConstants.LOAD_TECH;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[0].level = 1;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[1] = new IdLevel();
         m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[1].id = TechConstants.MAKE_TECH;
         m_troopinfo[String(TFConstants.T_CARRIAGE)].tech[1].level = 3;
         m_troopinfo[String(TFConstants.T_BALLISTA)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_BALLISTA)].name = "ballista";
         m_troopinfo[String(TFConstants.T_BALLISTA)].shortname = "ball";
         m_troopinfo[String(TFConstants.T_BALLISTA)].troopbeanname = "ballista";
         m_troopinfo[String(TFConstants.T_BALLISTA)].pop = 5;
         m_troopinfo[String(TFConstants.T_BALLISTA)].food = 2500;
         m_troopinfo[String(TFConstants.T_BALLISTA)].wood = 3000;
         m_troopinfo[String(TFConstants.T_BALLISTA)].stone = 0;
         m_troopinfo[String(TFConstants.T_BALLISTA)].iron = 1800;
         m_troopinfo[String(TFConstants.T_BALLISTA)].level = 9;
         m_troopinfo[String(TFConstants.T_BALLISTA)].minutes = 50;
         m_troopinfo[String(TFConstants.T_BALLISTA)].tech = new Array();
         m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0].id = TechConstants.MAKE_TECH;
         m_troopinfo[String(TFConstants.T_BALLISTA)].tech[0].level = 5;
         m_troopinfo[String(TFConstants.T_BALLISTA)].tech[1] = new IdLevel();
         m_troopinfo[String(TFConstants.T_BALLISTA)].tech[1].id = TechConstants.THROW_SKILL;
         m_troopinfo[String(TFConstants.T_BALLISTA)].tech[1].level = 6;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].name = "ram";
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].shortname = "ram";
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].troopbeanname = "batteringRam";
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].pop = 10;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].food = 4000;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].wood = 6000;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].stone = 0;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].iron = 1500;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].level = 9;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].minutes = 75;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech = new Array();
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0].id = TechConstants.MAKE_TECH;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[0].level = 7;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[1] = new IdLevel();
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[1].id = TechConstants.DEFEND_SKILL;
         m_troopinfo[String(TFConstants.T_BATTERINGRAM)].tech[1].level = 8;
         m_troopinfo[String(TFConstants.T_CATAPULT)] = new TroopInfo();
         m_troopinfo[String(TFConstants.T_CATAPULT)].name = "catapult";
         m_troopinfo[String(TFConstants.T_CATAPULT)].shortname = "pult";
         m_troopinfo[String(TFConstants.T_CATAPULT)].troopbeanname = "catapult";
         m_troopinfo[String(TFConstants.T_CATAPULT)].pop = 8;
         m_troopinfo[String(TFConstants.T_CATAPULT)].food = 5000;
         m_troopinfo[String(TFConstants.T_CATAPULT)].wood = 5000;
         m_troopinfo[String(TFConstants.T_CATAPULT)].stone = 8000;
         m_troopinfo[String(TFConstants.T_CATAPULT)].iron = 1200;
         m_troopinfo[String(TFConstants.T_CATAPULT)].level = 10;
         m_troopinfo[String(TFConstants.T_CATAPULT)].minutes = 100;
         m_troopinfo[String(TFConstants.T_CATAPULT)].tech = new Array();
         m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0] = new IdLevel();
         m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0].id = TechConstants.MAKE_TECH;
         m_troopinfo[String(TFConstants.T_CATAPULT)].tech[0].level = 10;
         m_troopinfo[String(TFConstants.T_CATAPULT)].tech[1] = new IdLevel();
         m_troopinfo[String(TFConstants.T_CATAPULT)].tech[1].id = TechConstants.THROW_SKILL;
         m_troopinfo[String(TFConstants.T_CATAPULT)].tech[1].level = 10;
      }
      
      public static function getBarrackArray(param1:CityState, param2:int) : Array
      {
         var _loc4_:BuildingBean = null;
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1.castle.buildingsArray)
         {
            if(_loc4_.typeId == BuildingConstants.TYPE_BARRACK)
            {
               if(_loc4_.level >= param2)
               {
                  _loc3_[_loc3_.length] = _loc4_;
               }
            }
         }
         return _loc3_;
      }
      
      private static function getMaxAmountPopulationOnly(param1:CityState, param2:int) : Number
      {
         staticInit();
         var _loc3_:Number = 0;
         var _loc4_:TroopInfo = m_troopinfo[String(param2)];
         var _loc5_:int = param1.castle.resource.curPopulation - param1.castle.resource.workPeople;
         if(_loc4_.pop == 0)
         {
            _loc3_ = -1;
         }
         else if(_loc5_ > 0)
         {
            _loc3_ = _loc5_ / _loc4_.pop;
         }
         else
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      private static function cityHasEnoughResearch(param1:CityState, param2:int) : Boolean
      {
         var _loc6_:IdLevel = null;
         staticInit();
         var _loc3_:Boolean = true;
         var _loc4_:TroopInfo = m_troopinfo[String(param2)];
         var _loc5_:Object = param1.getTechLevels();
         for each(_loc6_ in _loc4_.tech)
         {
            if(!_loc5_.hasOwnProperty(String(_loc6_.id)) || _loc5_[String(_loc6_.id)] < _loc6_.level)
            {
               _loc3_ = false;
               break;
            }
         }
         return _loc3_;
      }
      
      private static function staticInit() : void
      {
         if(m_troopinfo == null)
         {
            troopinfoInit();
         }
      }
      
      private static function getValidBarrackId(param1:CityState, param2:int, param3:int, param4:Boolean) : int
      {
         var _loc6_:BuildingBean = null;
         staticInit();
         var _loc5_:Array = getBarrackArray(param1,m_troopinfo[String(param2)].level);
         if(_loc5_.length > 0)
         {
            if(param4)
            {
               return (_loc5_[0] as BuildingBean).positionId;
            }
            for each(_loc6_ in _loc5_)
            {
               if(_loc6_.positionId == param3)
               {
                  return param3;
               }
            }
         }
         return -1;
      }
   }
}

class TroopInfo
{
   
   public var level:int = 0;
   
   public var stone:int = 0;
   
   public var shortname:String = "";
   
   public var iron:int = 0;
   
   public var name:String = "";
   
   public var wood:int = 0;
   
   public var pop:int = 0;
   
   public var troopbeanname:String = "";
   
   public var tech:Array = new Array();
   
   public var food:int = 0;
   
   public var minutes:Number = 0;
   
   public function TroopInfo()
   {
      super();
   }
}

class IdLevel
{
   
   public var id:int = -9999;
   
   public var level:int = 0;
   
   public function IdLevel()
   {
      super();
   }
}

class MaxAmount
{
   
   public var max:int = 0;
   
   public var barrackid:int = 0;
   
   public var maxbyresource:Number = 0;
   
   public var maxNumber:Number = 0;
   
   public var hasbarrack:Boolean = false;
   
   public var hasresearch:Boolean = false;
   
   public var maxbypop:Number = 0;
   
   public function MaxAmount()
   {
      super();
   }
}
