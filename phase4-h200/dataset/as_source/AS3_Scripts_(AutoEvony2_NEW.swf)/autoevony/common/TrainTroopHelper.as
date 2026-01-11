// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.TrainTroopHelper

package autoevony.common
{
    import com.evony.common.beans.CastleResourceBean;
    import autoevony.scripts.CityState;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.constants.TFConstants;
    import com.evony.common.constants.TechConstants;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;

    public class TrainTroopHelper 
    {

        private static var m_troopinfo:Object = null;


        private static function getMaxAmountResourceOnly(_arg_1:CityState, _arg_2:int):Number
        {
            staticInit();
            var _local_3:Number = -1;
            var _local_4:TroopInfo = m_troopinfo[String(_arg_2)];
            var _local_5:CastleResourceBean = _arg_1.castle.resource;
            if (_local_4.food > 0)
            {
                _local_3 = myMin(_local_3, (_local_5.food.amount / Number(_local_4.food)), -1);
            };
            if (_local_4.wood > 0)
            {
                _local_3 = myMin(_local_3, (_local_5.wood.amount / Number(_local_4.wood)), -1);
            };
            if (_local_4.stone > 0)
            {
                _local_3 = myMin(_local_3, (_local_5.stone.amount / Number(_local_4.stone)), -1);
            };
            if (_local_4.iron > 0)
            {
                _local_3 = myMin(_local_3, (_local_5.iron.amount / Number(_local_4.iron)), -1);
            };
            if (_local_3 == -1)
            {
                _local_3 = 0;
            };
            return (_local_3);
        }

        public static function lookupName(_arg_1:int):String
        {
            staticInit();
            var _local_2:* = "Error";
            if (m_troopinfo.hasOwnProperty(String(_arg_1)))
            {
                _local_2 = m_troopinfo[String(_arg_1)].name;
            };
            return (_local_2);
        }

        private static function myMin(_arg_1:Number, _arg_2:Number, _arg_3:Number=NaN):Number
        {
            var _local_4:Number = NaN;
            if (((!(isNaN(_arg_3))) && (_arg_1 == _arg_3)))
            {
                _local_4 = _arg_2;
            }
            else
            {
                if (_arg_1 < _arg_2)
                {
                    _local_4 = _arg_1;
                }
                else
                {
                    if (_arg_2 <= _arg_1)
                    {
                        _local_4 = _arg_2;
                    };
                };
            };
            return (_local_4);
        }

        public static function getTrainObj(_arg_1:CityState, _arg_2:TroopBean, _arg_3:int, _arg_4:Boolean, _arg_5:int):Object
        {
            var _local_7:int;
            var _local_8:String;
            var _local_9:MaxAmount;
            staticInit();
            var _local_6:Object = {
                "troopid":0,
                "barrackid":0,
                "amount":0,
                "errormsg":""
            };
            if (_arg_2 == null)
            {
                _local_6.errormsg = "Invalid troops";
            }
            else
            {
                _local_7 = 0;
                for (_local_8 in m_troopinfo)
                {
                    if (_arg_2[m_troopinfo[_local_8].troopbeanname] > 0)
                    {
                        _local_6.troopid = int(_local_8);
                        _local_6.amount = _arg_2[m_troopinfo[_local_8].troopbeanname];
                        _local_7++;
                    };
                };
                if (_local_7 != 1)
                {
                    _local_6.troopid = 0;
                    _local_6.amount = 0;
                    if (_local_7 > 1)
                    {
                        _local_6.errormsg = "Only one troop type allowed";
                    }
                    else
                    {
                        _local_6.errormsg = "No troop type found";
                    };
                }
                else
                {
                    if (_local_6.amount <= 0)
                    {
                        _local_6.errormsg = "Must specify 1 or more amount to train";
                    }
                    else
                    {
                        _local_9 = getMaxAmount(_arg_1, _local_6.troopid, _arg_3, _arg_4);
                        if (((_local_9.max <= 0) || (_local_9.max < _arg_5)))
                        {
                            _local_6.errormsg = (("Cannot train " + lookupName(_local_6.troopid)) + " lacking:");
                            if (!_local_9.hasresearch)
                            {
                                _local_6.errormsg = (_local_6.errormsg + " research");
                            };
                            if (!_local_9.hasbarrack)
                            {
                                _local_6.errormsg = (_local_6.errormsg + " barrack");
                            };
                            if (_local_9.maxbyresource < _arg_5)
                            {
                                _local_6.errormsg = (_local_6.errormsg + ((" resources (max troops by resources:" + _local_9.maxbyresource) + ") "));
                            };
                            if (_local_9.maxbypop < _arg_5)
                            {
                                _local_6.errormsg = (_local_6.errormsg + ((" idle pop (max troops by pop:" + _local_9.maxbypop) + ") "));
                            };
                        }
                        else
                        {
                            _local_6.amount = Math.min(_local_9.max, _local_6.amount);
                            _local_6.barrackid = _local_9.barrackid;
                        };
                    };
                };
            };
            return (_local_6);
        }

        private static function getMaxAmount(_arg_1:CityState, _arg_2:int, _arg_3:int, _arg_4:Boolean):MaxAmount
        {
            staticInit();
            var _local_5:MaxAmount = new MaxAmount();
            var _local_6:int = getValidBarrackId(_arg_1, _arg_2, _arg_3, _arg_4);
            _local_5.hasbarrack = (_local_6 > -1);
            _local_5.barrackid = ((_local_5.hasbarrack) ? int(_local_6) : 0);
            _local_5.hasresearch = cityHasEnoughResearch(_arg_1, _arg_2);
            _local_5.maxbypop = getMaxAmountPopulationOnly(_arg_1, _arg_2);
            _local_5.maxbyresource = getMaxAmountResourceOnly(_arg_1, _arg_2);
            if (((_local_5.hasresearch) && (_local_5.hasbarrack)))
            {
                _local_5.maxNumber = myMin(_local_5.maxbypop, _local_5.maxbyresource);
                if (_local_5.maxNumber >= int.MAX_VALUE)
                {
                    _local_5.max = int.MAX_VALUE;
                }
                else
                {
                    _local_5.max = int(_local_5.maxNumber);
                };
            };
            return (_local_5);
        }

        private static function troopinfoInit():void
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
            m_troopinfo[String(TFConstants.T_PEASANTS)].minutes = (50 / 60);
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
            m_troopinfo[String(TFConstants.T_MILITIA)].minutes = (25 / 60);
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
            m_troopinfo[String(TFConstants.T_SCOUTER)].minutes = (1 + (40 / 60));
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
            m_troopinfo[String(TFConstants.T_SWORDSMEN)].minutes = (3 + (45 / 60));
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
            m_troopinfo[String(TFConstants.T_ARCHER)].minutes = (5 + (50 / 60));
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
            m_troopinfo[String(TFConstants.T_LIGHTCAVALRY)].minutes = (8 + (20 / 60));
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
            m_troopinfo[String(TFConstants.T_CARRIAGE)].minutes = (16 + (40 / 60));
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

        public static function getBarrackArray(_arg_1:CityState, _arg_2:int):Array
        {
            var _local_4:BuildingBean;
            var _local_3:Array = new Array();
            for each (_local_4 in _arg_1.castle.buildingsArray)
            {
                if (_local_4.typeId == BuildingConstants.TYPE_BARRACK)
                {
                    if (_local_4.level >= _arg_2)
                    {
                        _local_3[_local_3.length] = _local_4;
                    };
                };
            };
            return (_local_3);
        }

        private static function getMaxAmountPopulationOnly(_arg_1:CityState, _arg_2:int):Number
        {
            staticInit();
            var _local_3:Number = 0;
            var _local_4:TroopInfo = m_troopinfo[String(_arg_2)];
            var _local_5:int = (_arg_1.castle.resource.curPopulation - _arg_1.castle.resource.workPeople);
            if (_local_4.pop == 0)
            {
                _local_3 = -1;
            }
            else
            {
                if (_local_5 > 0)
                {
                    _local_3 = (_local_5 / _local_4.pop);
                }
                else
                {
                    _local_3 = 0;
                };
            };
            return (_local_3);
        }

        private static function cityHasEnoughResearch(_arg_1:CityState, _arg_2:int):Boolean
        {
            var _local_6:IdLevel;
            staticInit();
            var _local_3:Boolean = true;
            var _local_4:TroopInfo = m_troopinfo[String(_arg_2)];
            var _local_5:Object = _arg_1.getTechLevels();
            for each (_local_6 in _local_4.tech)
            {
                if (((!(_local_5.hasOwnProperty(String(_local_6.id)))) || (_local_5[String(_local_6.id)] < _local_6.level)))
                {
                    _local_3 = false;
                    break;
                };
            };
            return (_local_3);
        }

        private static function staticInit():void
        {
            if (m_troopinfo == null)
            {
                troopinfoInit();
            };
        }

        private static function getValidBarrackId(_arg_1:CityState, _arg_2:int, _arg_3:int, _arg_4:Boolean):int
        {
            var _local_6:BuildingBean;
            staticInit();
            var _local_5:Array = getBarrackArray(_arg_1, m_troopinfo[String(_arg_2)].level);
            if (_local_5.length > 0)
            {
                if (_arg_4)
                {
                    return ((_local_5[0] as BuildingBean).positionId);
                };
                for each (_local_6 in _local_5)
                {
                    if (_local_6.positionId == _arg_3)
                    {
                        return (_arg_3);
                    };
                };
            };
            return (-1);
        }


    }
}//package autoevony.common

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


}

class IdLevel 
{

    public var id:int = -9999;
    public var level:int = 0;


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


}


