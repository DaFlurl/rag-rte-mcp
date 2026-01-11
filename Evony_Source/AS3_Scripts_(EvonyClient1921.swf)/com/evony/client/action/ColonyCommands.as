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
    import com.evony.common.module.colony.ColonialArmyResponse;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.module.colony.ColonialDeployResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class ColonyCommands 
    {

        public var _uprise_callback:Function;
        public var _levyArmy_callback:Function;
        public var _abandonColony_callback:Function;
        public var _getDeployTroopsInfo_callback:Function;
        public var _setDeployTroops_callback:Function;
        public var _levyPopulation_callback:Function;
        public var _overviewColonialCastle_callback:Function;
        public var _reduceArmaments_callback:Function;
        public var _levyTaxes_callback:Function;
        public var _getColonialCastlesInfo_callback:Function;
        public var _levyFood_callback:Function;
        public var _getColonialArmyInfo_callback:Function;
        public var _getSuzerainColonialCastlesInfo_callback:Function;
        public var _speedUpAbandonColony_callback:Function;
        public var _sowDiscord_callback:Function;
        private var sender:Sender;


        public function levyArmy(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyArmy_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.levyArmy", _local_4);
            };
            return (null);
        }

        public function getColonialCastlesInfo(_arg_1:int, _arg_2:Function=null):ColonialCastlesRespone
        {
            this._getColonialCastlesInfo_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("colony.getColonialCastlesInfo", _local_3);
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
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.overviewColonialCastle", _local_4);
            };
            return (null);
        }

        public function abandonColony(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._abandonColony_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.abandonColony", _local_4);
            };
            return (null);
        }

        public function sowDiscord(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._sowDiscord_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.sowDiscord", _local_4);
            };
            return (null);
        }

        public function getColonialArmyInfo(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonialArmyResponse
        {
            this._getColonialArmyInfo_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.getColonialArmyInfo", _local_4);
            };
            return (null);
        }

        public function setDeployTroops(_arg_1:int, _arg_2:int, _arg_3:TroopBean, _arg_4:Function=null):CommandResponse
        {
            this._setDeployTroops_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.targetCastleId = _arg_2;
            _local_5.troopBean = _arg_3.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("colony.setDeployTroops", _local_5);
            };
            return (null);
        }

        public function getSuzerainColonialCastlesInfo(_arg_1:int, _arg_2:Function=null):ColonialCastlesRespone
        {
            this._getSuzerainColonialCastlesInfo_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("colony.getSuzerainColonialCastlesInfo", _local_3);
            };
            return (null);
        }

        public function levyPopulation(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyPopulation_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.levyPopulation", _local_4);
            };
            return (null);
        }

        public function getDeployTroopsInfo(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonialDeployResponse
        {
            this._getDeployTroopsInfo_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.getDeployTroopsInfo", _local_4);
            };
            return (null);
        }

        public function reduceArmaments(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._reduceArmaments_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.reduceArmaments", _local_4);
            };
            return (null);
        }

        public function uprise(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._uprise_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("colony.uprise", _local_3);
            };
            return (null);
        }

        public function levyFood(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyFood_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.levyFood", _local_4);
            };
            return (null);
        }

        public function speedUpAbandonColony(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedUpAbandonColony_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.targetCastleId = _arg_2;
            _local_5.itemId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("colony.speedUpAbandonColony", _local_5);
            };
            return (null);
        }

        public function levyTaxes(_arg_1:int, _arg_2:int, _arg_3:Function=null):ColonyLevyeRespone
        {
            this._levyTaxes_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetCastleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("colony.levyTaxes", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

