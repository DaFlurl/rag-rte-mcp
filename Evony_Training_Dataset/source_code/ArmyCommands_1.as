// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ArmyCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.army.StayAllianceReponse;
    import com.evony.common.module.army.TroopParamResponse;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.module.army.ArmyPracticeResponse;
    import com.evony.common.paramBeans.NewArmyParam;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class ArmyCommands 
    {

        public var _setArmyGoOut_callback:Function;
        public var _callBackArmy_callback:Function;
        private var sender:Sender;
        public var _disbandFleeTroop_callback:Function;
        public var _newArmy_callback:Function;
        public var _getFleeTroop_callback:Function;
        public var _getTroopParam_callback:Function;
        public var _IsDropItemInCastle_callback:Function;
        public var _disbandInjuredTroop_callback:Function;
        public var _exerciseArmy_callback:Function;
        public var _getStayAllianceArmys_callback:Function;
        public var _cureInjuredTroop_callback:Function;
        public var _recruitFleeTroop_callback:Function;
        public var _setAllowAllianceArmy_callback:Function;
        public var _getInjuredTroop_callback:Function;


        public function IsDropItemInCastle(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._IsDropItemInCastle_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.x = _arg_1;
            _local_4.y = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("army.IsDropItemInCastle", _local_4);
            };
            return (null);
        }

        public function getStayAllianceArmys(_arg_1:int, _arg_2:Function=null):StayAllianceReponse
        {
            this._getStayAllianceArmys_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.getStayAllianceArmys", _local_3);
            };
            return (null);
        }

        public function disbandFleeTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._disbandFleeTroop_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.disbandFleeTroop", _local_3);
            };
            return (null);
        }

        public function recruitFleeTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._recruitFleeTroop_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.recruitFleeTroop", _local_3);
            };
            return (null);
        }

        public function getTroopParam(_arg_1:int, _arg_2:Function=null):TroopParamResponse
        {
            this._getTroopParam_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.getTroopParam", _local_3);
            };
            return (null);
        }

        public function exerciseArmy(_arg_1:int, _arg_2:TroopBean, _arg_3:TroopBean, _arg_4:Function=null):ArmyPracticeResponse
        {
            this._exerciseArmy_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.troopParamAttack = _arg_2.toObject();
            _local_5.troopParamDefend = _arg_3.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("army.exerciseArmy", _local_5);
            };
            return (null);
        }

        public function getFleeTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._getFleeTroop_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.getFleeTroop", _local_3);
            };
            return (null);
        }

        public function disbandInjuredTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._disbandInjuredTroop_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.disbandInjuredTroop", _local_3);
            };
            return (null);
        }

        public function newArmy(_arg_1:int, _arg_2:NewArmyParam, _arg_3:Function=null):CommandResponse
        {
            this._newArmy_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.newArmyBean = _arg_2.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("army.newArmy", _local_4);
            };
            return (null);
        }

        public function callBackArmy(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._callBackArmy_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.armyId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("army.callBackArmy", _local_4);
            };
            return (null);
        }

        public function getInjuredTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._getInjuredTroop_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.getInjuredTroop", _local_3);
            };
            return (null);
        }

        public function setAllowAllianceArmy(_arg_1:int, _arg_2:Boolean, _arg_3:Function=null):CommandResponse
        {
            this._setAllowAllianceArmy_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.isAllow = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("army.setAllowAllianceArmy", _local_4);
            };
            return (null);
        }

        public function setArmyGoOut(_arg_1:int, _arg_2:Boolean, _arg_3:Function=null):CommandResponse
        {
            this._setArmyGoOut_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.isArmyGoOut = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("army.setArmyGoOut", _local_4);
            };
            return (null);
        }

        public function cureInjuredTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._cureInjuredTroop_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("army.cureInjuredTroop", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

