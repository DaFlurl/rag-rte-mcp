// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ColonyCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.colony.ColonyLevyeRespone;
    import com.evony.common.module.colony.ColonialCastlesRespone;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.module.colony.ColonialArmyResponse;
    import com.evony.common.module.colony.ColonialDeployResponse;

    public class ColonyCommands 
    {

        public var _uprise_callback:Function;
        public var _levyArmy_callback:Function;
        public var _abandonColony_callback:Function;
        public var _getDeployTroopsInfo_callback:Function;
        public var _speedUpAbandonColony_callback:Function;
        public var _reduceArmaments_callback:Function;
        public var _levyPopulation_callback:Function;
        public var _overviewColonialCastle_callback:Function;
        public var _setDeployTroops_callback:Function;
        public var _levyTaxes_callback:Function;
        public var _levyFood_callback:Function;
        public var _getColonialArmyInfo_callback:Function;
        public var _sowDiscord_callback:Function;
        private var sender:Sender;
        public var _getColonialCastlesInfo_callback:Function;
        public var _getSuzerainColonialCastlesInfo_callback:Function;


        public function levyArmy(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyArmy_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.levyArmy", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function getColonialCastlesInfo(_arg_1:int, _arg_2:Function=null):ColonialCastlesRespone
        {
            this._getColonialCastlesInfo_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.getColonialCastlesInfo", {"castleId":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function overviewColonialCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):OverviewColonyCastleRespone
        {
            this._overviewColonialCastle_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.overviewColonialCastle", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function abandonColony(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._abandonColony_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.abandonColony", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function sowDiscord(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._sowDiscord_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.sowDiscord", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function getSuzerainColonialCastlesInfo(_arg_1:int, _arg_2:Function=null):ColonialCastlesRespone
        {
            this._getSuzerainColonialCastlesInfo_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.getSuzerainColonialCastlesInfo", {"castleId":_arg_1});
            };
            return (null);
        }

        public function setDeployTroops(_arg_1:int, _arg_2:int, _arg_3:TroopBean, _arg_4:Function=null):CommandResponse
        {
            this._setDeployTroops_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.setDeployTroops", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2,
                    "troopBean":_arg_3.toObject()
                });
            };
            return (null);
        }

        public function uprise(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._uprise_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.uprise", {"castleId":_arg_1});
            };
            return (null);
        }

        public function getColonialArmyInfo(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonialArmyResponse
        {
            this._getColonialArmyInfo_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.getColonialArmyInfo", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function levyPopulation(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyPopulation_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.levyPopulation", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function getDeployTroopsInfo(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonialDeployResponse
        {
            this._getDeployTroopsInfo_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.getDeployTroopsInfo", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function reduceArmaments(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._reduceArmaments_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.reduceArmaments", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function levyFood(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyFood_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.levyFood", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }

        public function speedUpAbandonColony(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedUpAbandonColony_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.speedUpAbandonColony", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2,
                    "itemId":_arg_3
                });
            };
            return (null);
        }

        public function levyTaxes(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyTaxes_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("colony.levyTaxes", {
                    "castleId":_arg_1,
                    "targetCastleId":_arg_2
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

